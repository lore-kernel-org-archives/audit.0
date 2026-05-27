Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323333987E
	for <audit@vger.kernel.org>; Wed, 27 May 2026 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924506; cv=pass; b=MAF0CQlJ3JiWFCuZ5c0gyg6vVrbzPQygjD0hi7wfMnQ2eKPTCwg06uCvuQ6CemDXvfTeuiAShuKopdx7wD0uUwnfkqXzPIcu11et55UXxQIh3gYg6GKPOLHQ73Fx+ZuK3UCz+mVrd9hCqEaz1YRm0MvsZ8Ap22XGvB3B+OtOJEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924506; c=relaxed/simple;
	bh=KeLU1eDuBZ4CMy/KV2Fb/Ragnxdbp/6GlWpWzvHftg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVPY8P/kh8Kr7TgwsrYMPY6knoSVFilo4QcpukZu79iF+jH+P/7TM+jiAJesqqIr8lZPdh53WNaVdUdK/7RNix6sizQTFxDTDCrf9v89+xXbwoosSXEr/tpgpPsW3e4LpLTRAHLLW0jtBJ1uFNFtuZUrClpJa9f9d90rHDh0J5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IrtiuyKO; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IrtiuyKO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835386ff122so12339788b3a.3
        for <audit@vger.kernel.org>; Wed, 27 May 2026 16:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779924505; cv=none;
        d=google.com; s=arc-20240605;
        b=QFP9J5d+0WmOneMhN8PpJspV2RLE69Ib5fZXreW9E/gPSDqtlrdTlK1YHUwL2gsPVJ
         a+y18EbCGi5W6JfxojWpN9Ahzii9M8MjZUNnArQIj9SVP6jq/DBhq1UxQDpGpL/zY7ak
         JL4Tz8Yui0qiR6qLooKCaRnfZiFQSaoHq3QV2F4wn4fQguqI4ECfOqthFkFCvjXcZtVH
         k3N3IBJAt6xk97mD49jfeoFQ/9y+WS/Fp7j7nIZxIkWrXjEB2W1lk7bngvvgCLTOclZ2
         nR1ieOtVh4CnXJhra1XJ47FlNbfIQ/zVtJcKW8ZMWUA2PIoLKRIUtRBSeV/jpFm4lYO3
         9gMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9IYz0hfcBU0H6vORUO3iSoFTkkBWVqB4Qme4LgDNhoU=;
        fh=JB08B6JmvPj9m6SqcUSgoQQnrZ7yfCalTQLPv4BotVk=;
        b=aWujJtSwDZZAkDcvwHhQB7hhkJnbHFee85hdo+6E7jEq0fAhxwO0MwDXeXQpfzl4Fb
         hDXfD+YSrOLxSp3SjMCVLeBFZ+vaHdWGPYewnXrZSZSFHDGGmrCIoye+n7Lyx5yuxelM
         UJ1RHreBGUdykK+z52vWhl5pLRvWrKveuqd7RXn3HT0gBWA3E+mGfCDqha8n1uo/zgmd
         gim00PxG1y2XIjUfXkPHCDWWH4p/ekr4oGdKbgrhRcSHal+vuA41FdPoCP03CnzZOn9P
         Vgq/tOP2GX/2memjSsQm7poc5FVCnsFczN6NzMuMjr8on6TF8zevI8kkMBgSW5luO5gK
         hg5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779924505; x=1780529305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IYz0hfcBU0H6vORUO3iSoFTkkBWVqB4Qme4LgDNhoU=;
        b=IrtiuyKOaOvr+KBdEOshIRfqxnQHJmBmUfizW9JdKfZyvaAnD04CP+HoGFFjpMztPF
         4tB0tRS3hxQe2BrPAszNxM/3QWL3ixY/9khE3x7RRM990e8XFopwLYaVywvIh6V1vG41
         uph2pH9QWP7gRmvvAlxcQGcqB3cRT+hFQ3d7dekHFkplckxk/oUB7jjaid5Ey5w6uq/X
         PeRHF33c/WNmJ2/gww1Rc3AJONj7A3AVmDW1XzujotazxUu/X0+LFe/0CI07O3dEwZ7k
         V+YdfHwv43UQ/c06z9l+GnZhUOoOqjp4GWDH/ZVQkvyB8hlie6wXp9EiSLdcyyh7nCk2
         DE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779924505; x=1780529305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IYz0hfcBU0H6vORUO3iSoFTkkBWVqB4Qme4LgDNhoU=;
        b=iSJ1eyzbykpiiLzJUotPYd7b/zZqDKAtDJl4yauHWme6LfTOvjbpzIMd38JhworSgd
         ug8rab3GwmUU8BYNpU1fYizIbUBcbAls5+lZ0mUIQ0EBwXAAsuBNw4bHywxx2oojSG/G
         mrQTeTNnbxi20KOGMkXY0fB5/ZnFZn8owAvjXyehisVMctUtR1ZQpXhIwQTGuiImzwY3
         lmOhA++HRxfK4IP/n2+427picJHYllWf2smYd5jlmDPzMdLWMB0WPPmjLj2jeilZvZPl
         z6BsUD41it+y9crU1A3zI6JrJvwizZM/kADdBeUTX5Q2w1iazAH1V1Km7R6yV4tN10u3
         sLvg==
X-Forwarded-Encrypted: i=1; AFNElJ8U6nCLs29gP2aYr8081zNePnCIzqJVC05dTkrhIl5GAgJ5UanOfjX3z/Ddt6gtkRTCLf9ktg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK4tZjiNLfeZhDBMC/b6Zv+XrbeWQ7hhxe/KslUxPidji/pPaE
	jwS1UmONVHgU4du3b4ycc8V5H5fo5DPsj2URHdiekZiiqtbUmLwuzX//Tk9pwSHsxcik7j/i/Ji
	OI93Mu0FF3Ztz3GHX+J/XepSAJs/wJEIyJehL9ZUx
X-Gm-Gg: Acq92OHXLq69VIQoqR/LOuI3VlgPrimWMf8dA0BwksJ3cOAisQ4IsqqPRPkufmAluQz
	gZGe0yBnyhp5RvBFYz+Hwc/hjpXsBqLy34Gf2e7YtvnKPFZGWNvM7pGlfH98GJ0e3PC+OhBuvmC
	kFLeupVzu4Nka4MHChHvYtUOCpdF0ZmBiDZvYr8L9U8XGy0bCCsmjYZe57cBmdYZHXoHAfalGYW
	Ke/6AwN7fHzy+pOEBX0mpaLQM1kJtMP/j+eoH/8pxl4fp5eBKw+iy/04+YO0NHBh0tLpuXW//Ed
	GhEJDUZeBfHR1oRxaA==
X-Received: by 2002:a05:6a00:3003:b0:82c:d986:e917 with SMTP id
 d2e1a72fcca58-8415f56374bmr24308110b3a.22.1779924504640; Wed, 27 May 2026
 16:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527-audit-update-macro-stubs-v1-1-8cda8dbdae0a@kernel.org>
 <CAABTaaCZD-6_ar-H8iwOka9WgtuqwEt+=umVuc5xsBHwDcnD-Q@mail.gmail.com>
 <CAHC9VhQfci2gE-eD67DbjL21s7tF+rPWa9bdu0Kk5cfW+gz2Xg@mail.gmail.com> <20260527211235.GA3191279@ax162>
In-Reply-To: <20260527211235.GA3191279@ax162>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 May 2026 19:28:12 -0400
X-Gm-Features: AVHnY4IPeeXdZwFiJ88nMoe-_KMFC6vUjpp5zZqFoG637xclFnzNbsM-EU0L7fY
Message-ID: <CAHC9VhRYY-TygCSuii-kjJ0q4AQXqkuccdDp2a+zq3tB-qcjMg@mail.gmail.com>
Subject: Re: [PATCH] audit: Update audit_alloc_mark() and audit_dupe_exe()
 CONFIG_AUDITSYSCALL=n stubs
To: Nathan Chancellor <nathan@kernel.org>, Ricardo Robaina <rrobaina@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Waiman Long <longman@redhat.com>, 
	Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:12=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Wed, May 27, 2026 at 03:13:06PM -0400, Paul Moore wrote:
> > Do either of you mind if I squash these two patches together in the
> > audit tree?  I would preserve Nathan's sign-off line and add a comment
> > at the end of the commit description about the fix provided by Nathan.
>
> Sure, I have no qualms with this being squashed with a sufficient note
> that I only provided a compile fix up.

Thanks all.  I just squashed the two patches, including Nathan's
sign-off as well as this note at the end of the commit description:

 "P.P.S: With the permission of both Ricardo and Nathan, I've squashed a
  fixup patch from Nathan that addresses a compile time error when
  CONFIG_AUDITSYSCALL=3Dn."

... if either of you has any concerns about this please let me know
and we'll address them.

The patch can be viewed in the audit/dev branch, and at the link below:

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git/commit/?h=
=3Ddev&id=3D78e3417e5f7c8b25234baadc3875ce7de109bb37

Thanks again everyone!

--=20
paul-moore.com
