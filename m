Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671E38E5E1
	for <audit@vger.kernel.org>; Mon, 13 Apr 2026 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118390; cv=none; b=UJ6v3ZwqkCsDqQNifflX5nVVTpgWdLj2q+VOL9I+Rj+0RA4T7XbxJA8lB3mn9YzmF6Te4Z6VBAoTX6ASpb4mw5FY/CHh/tpAwQQ9LBuaSE6ZEr0LKxNIyNdtYSEdLWiROt3R6XZokLNNnwloRRasuEFFlcFADQsXcllvaX+8+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118390; c=relaxed/simple;
	bh=mzSETmPlB3/o3Z/vnqCDwq26ZuYicrt2MOHS0C4VMJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VizX5zoKLBsK8XpTQA/q0msOe0w1rxnaSY6iSuxhUk4YOje5tR4ZFcC+38Wt39SA4b8kC/Fs6l/25/hU+vlLYVnRYlTN4g2R6o9ceru83SeePXqJqUSSU8Y4TIBxxva7WVzSUOTkv7KDIP7zyLgnLsseXiGS3GS7ZUCG0Ua3hrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YsnMJ9j1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YsnMJ9j1"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b936331786dso569057966b.3
        for <audit@vger.kernel.org>; Mon, 13 Apr 2026 15:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776118387; x=1776723187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MIVqdVMRO1TGBX25sA3Ic6pDeH5wiL9H+6o50VCf3KQ=;
        b=YsnMJ9j1WLIE4+KLxMSXLUXLrZCqOwRrlvUuL2s3naiZyODTPhgcfnasjI2CeuhB7e
         diqwGjqHRzebOG4Gtz4L7+QInkj6F6AOTPWiOVn7sJZ/jCnpTeA/DqqjW8s7//gz4dM9
         GBxBkMJiNsZ23yPkA45WVPtOicyrYl8umFpL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118387; x=1776723187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIVqdVMRO1TGBX25sA3Ic6pDeH5wiL9H+6o50VCf3KQ=;
        b=M6QELEzqTDFGCQFAb69e87y+kDl1KETs2MhkpHD1TPDU5oYbO3BjcUB97YFj+jHdKS
         Z/ykrRPXpmnqLL/BWCoz12wuj/CPPKBekv7DtygTxBOaY5e7N0FatwkAox/pGBg3ZhJq
         S49tblHYWisO+6Dzb+j99qJjKtF7C3WnECKNpX5/cpU0A5BBnS/SkSZChWb3Tviu+ySd
         n55RBfXe17tioYx/7wZ3e5VXy6pYO8BH19uPE9pvBg4i4XEsBVNqi7GHeeGAoi3iwu2q
         zQbKgOUMkr77P6U9Ivqln5Yqk4YjmfxEk/bJcq48Is/MiNcrZ2aa1AQMbUYm2WmEt/J4
         wosw==
X-Gm-Message-State: AOJu0YxDXK0FNQ9kjp0gDhxZaPArw574oD3R6lGyaJq4JObrTAYUIYfq
	NwOPOac4uk7Qz8cuFK4Ob3tGW/Hg/1wnOs9bz6MPLqoswKhw2jhbBx0lWVWxwp7YEhyV7BZJhQ/
	b2y24BBk=
X-Gm-Gg: AeBDietN376Rg0l9qLqteCfnW0Sj73ZgmpoT4aWpbCBUaGaBntYLV5Zts8cyHwlS6Vj
	6K+W4GVVKQ/6CSqQmBzthu/ZzSlBIQHeKWyBldn9FhoDi6FTnRV6jv9uYqsu0NMSgw8jijXZc5/
	hXnRbAb8wy1z31sjM6wMyfrTXW95v58HX7Np2SsTzbomcUp1zyfXNLlRJU/6W+IW+BAl/n6BcqU
	yLrPt3YYhIr5qbEH5qJAZXC9SFPNzll4/xJpH7uA/Vubo62Q5PoID68GnlZ3lYHP8OYNKBAEYLs
	zApeCE0kYOs0csKBsyDl5amH2Bw9p0wkfOeRpNmGOTS70IoxME9jNGJ1PVh94Mt7t2YmSWPEGQV
	oQ+tpQKEOwBg9S/+pD9wPPqVIHO/tdDQEjkAscR/g0RqU5sdDiCFWtYdPYuq7sJdMDhZMUVFZXk
	DAkLl2U62VmMJoJHpFb7M2pHPvae7Ju7KKWIDIB1zcZ7JMxC4Oyz1vAdZ2lBiVUGxvr9A7MOlk
X-Received: by 2002:a17:907:8e11:b0:b9c:b9c3:3ead with SMTP id a640c23a62f3a-b9d727d6016mr834327366b.43.1776118387257;
        Mon, 13 Apr 2026 15:13:07 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a13sm344425566b.53.2026.04.13.15.13.06
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 15:13:06 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6715594a4c2so1893444a12.1
        for <audit@vger.kernel.org>; Mon, 13 Apr 2026 15:13:06 -0700 (PDT)
X-Received: by 2002:a05:6402:505c:b0:66b:b6e2:66e1 with SMTP id
 4fb4d7f45d1cf-6707a47e6a3mr5418416a12.18.1776118386318; Mon, 13 Apr 2026
 15:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com>
In-Reply-To: <dea7bb546d49cbb8f342e016235ba4c3@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Apr 2026 15:12:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCBBHUL=9K1iMrXFDPmfT5Wsu2oXDaADLG7j160OikhA@mail.gmail.com>
X-Gm-Features: AQROBzC3Q1qQXWrjDvUH8H78O140BdYwUpHruuGfixEkpcUeLjE4A-3DuBofrBo
Message-ID: <CAHk-=wjCBBHUL=9K1iMrXFDPmfT5Wsu2oXDaADLG7j160OikhA@mail.gmail.com>
Subject: Re: [GIT PULL] audit/audit-pr-20260410
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 16:26, Paul Moore <paul@paul-moore.com> wrote:
>
> We've only got a few audit patches for the v7.1 merge window, the
> highlights are below:

Pulled. However, can I ask you to take a look at my reply to one of
the vfs pulls, which was actually triggered by audit overhead?

It's entirely unrelated to this particular audit pull, but maybe you
have comments? See

    https://lore.kernel.org/all/CAHk-=wiW53j3vmc1Y58-E_8jUBJtjgAVxDRt+r-w3WPQN+Zm5w@mail.gmail.com/

and it's really all about that current "get_fs_pwd()" in
audit_alloc_name(), and the cache contention it causes when lots of
processes share the same pwd and you get everybody just updating the
path refcounts.

Would it be reasonable to do something along the lines I suggest,
where instead of getting that fairly "global" path refcount, instead
get a reference (with some way to do a copy-on-write break on it) to
'struct fs_struct' instead? No, we don't have that infrastructure (but
it doesn't seem _hugely_ complicated - famous last words), and yes, in
a heavily threaded app you'd still have potentially lots of threads
sharing a 'struct fs_struct', but at least that thing is local to the
process, so it's not shared beyond that.

And no, I don't expect that you'd actually start being interested in
the current root in auditing, but from a bigger VFS perspective, root
and pwd really are just two instances of the exact same thing and I
despise that spull that makes them different at a VFS level.

                  Linus
