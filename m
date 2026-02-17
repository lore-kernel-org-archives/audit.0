Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF826F2B0;
	Tue, 17 Feb 2026 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332575; cv=none; b=VpFr5wPFXA0NBYtk76Rxon7/QX7vjYa2FLahPABei/k2zh5XhncQ134vLm3Munctga9IkK4shisXL997vnIUAgC7OA5HVV5CeMDFMesL+XDeRLgaG3F1PzditSNUJ0HitgM6ubtlf1f/iYJRaD7AyzEUOlzTKaCDYwpK9WF6shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332575; c=relaxed/simple;
	bh=5QOLaUTibAv4adAr8JThfuYJG03rbOfo1+GgmTXHxjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CezooAJ8IouOVmILjridloBMZzLIgl1qBPxlxj8FOKMrMUbokbYOlOj0y9qmTnt9XT54HI1uibtnrmMPsimMRl4BTHyv1zDHkDd7MbEJRnNJmnPysHg+mv6kDi4JqzAHgZEtKwHxXtCegHjXFM9EN0ENjBY2VZwbOmhIi8jGR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2E/dusX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2E/dusX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D56C19423;
	Tue, 17 Feb 2026 12:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771332575;
	bh=5QOLaUTibAv4adAr8JThfuYJG03rbOfo1+GgmTXHxjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2E/dusX62WlyJjZ+AmOtmFkWtPsehIs/Z34/44qbrTU93CGUZdayhPDcN51/xvkN
	 kT/ojxwbL1R+t5TOwGTMi1nOefpbihE9sERpmLRXWDk7BDLbZ+kUaHiHbHhdQxigcP
	 mi53LAVNcFO5EBaDdtppyAtWZcfHVhqyQ36J0AyazzWJubZsbrp/jr9hyjnIx7w5Zp
	 WMVibVETn2OkXDizs5e7o6B61Ig00YzvdKbMZcDUK7zNkY8lzLkCr3zEM/H8aLMs88
	 RDWOs0U28FAtXHr2SnOo3fXwAvFEzxrTe1VRIiKfypnI/K0gvfxYogsUoBRiupW2wR
	 ts4BKAW5FXRIQ==
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	linux-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	Richard Guy Briggs <rgb@redhat.com>,
	Ricardo Robaina <rrobaina@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] bug in unshare(2) failure recovery
Date: Tue, 17 Feb 2026 13:49:21 +0100
Message-ID: <20260217-weltumsegelung-zergehen-a1d2ba31a4b7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207082524.GE3183987@ZenIV>
References: <20260207082524.GE3183987@ZenIV>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=brauner@kernel.org; h=from:subject:message-id; bh=5QOLaUTibAv4adAr8JThfuYJG03rbOfo1+GgmTXHxjc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROSb7lqeUxWXHbtin+tuczQxXcOhae/yu0+GjA7r8y0 68mX+ip6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI7jeGv6Jr7zKselMae2pR 5LxLZ2f37bN9/8l2wi2FEv7VTYdn6O9nZPh7XDoxOG9FtHnF1W7TeN4uzjjP34mHDntJ7vh1JXG BCgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 07 Feb 2026 08:25:24 +0000, Al Viro wrote:
> On Fri, Feb 06, 2026 at 03:04:53PM -0500, Waiman Long wrote:
> 
> [summary of subthread: there's an unpleasant corner case in unshare(2),
> when we have a CLONE_NEWNS in flags and current->fs hadn't been shared
> at all; in that case copy_mnt_ns() gets passed current->fs instead of
> a private copy, which causes interesting warts in proof of correctness]
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] bug in unshare(2) failure recovery
      https://git.kernel.org/vfs/vfs/c/c11eb27d36ff
