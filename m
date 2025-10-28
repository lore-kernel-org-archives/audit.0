Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE5201278
	for <audit@vger.kernel.org>; Tue, 28 Oct 2025 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641691; cv=none; b=JJtQ+IWWzOCZ1JFwVA0DLX1Yd/hXLrJeXf+AbWfsrVMa8/ikWin7a7rtVCL8YqDYT3eEG4y/Pb+aaW570ImsEP/LCg31J+plunraCXhQ3kLtqcB0+gY+6SL79ZO2XweHbHz3Fo2EmKwCLmQSBUarikm2vjCOLbTb37jTtKUcQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641691; c=relaxed/simple;
	bh=QeYx/eFxq6lR4+YZ/DP4VSYkYOnQaUkr9HNt8KAt9V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnSBF0HSFBtMGg73KlK2SJTwNGvF8SWqDAySpdvKz1PGdDY4ZpzqcSEpm/7HtBPex+nJ9kFl6ZDPY1tbbr7TOijgD+x7mdU/xNGdYalRJuB6PFLP9JKW3ZB9Be8p7XNBnj3o68/agL3T49GYxRIIPf5fVoqr3qh7orvDjBAQgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFjti9dY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFjti9dY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso2942286a12.1
        for <audit@vger.kernel.org>; Tue, 28 Oct 2025 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761641686; x=1762246486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zzTgGU8Fc6YeRB9n5ReEGGKnPVnwGcFzwEAmeAoo+6o=;
        b=zFjti9dYn8J4QTHiGtAwOeL3CC2dHxTOYfHv2mGg16qOaBgpifgevyxjJ9qLffs/Bg
         Y6s9EcXQvSIwCbpoA74vD+11teZ4P7G8wHUzx+2Ev4Po6xjcrs/4ErY1qV+tjJ9Gj/cG
         G4PKWLQU+aKQ3PD2CS/HYXP2XtlJEscOg31kXiPCT1YDCBBJKwNxrPAJQ5rKvZfBiqgR
         xjXrNg6334IkzeQd+fXVOKg1LA3jTrRqRONMoeOhn+0WdRLEWbFO125kaHW0dyht75II
         cWpezezAJxWAP79XOxPszpmw5nFbWjjmkaUy/g/g4zc5olxRLyPcsEnzN/NqwtO11Psw
         ygMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641686; x=1762246486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzTgGU8Fc6YeRB9n5ReEGGKnPVnwGcFzwEAmeAoo+6o=;
        b=Mde9w2ZsA2BPgXR3R0KbhGkIMhNfrcn7rhfA0Sl3SSuCpVQLC+Vy/3+AgEWHYeo+E0
         hcezAFCgQFWPxcNUW/yqJqlldPPLXquKNcylCzc+bWfxJ/JMGk2eGxM3p9Cppe94Zuc4
         SOSKbB5JSyUhhG1C2NS1QD0+csLft826+zicv4gZMPB8Yua6uc+zQ1IQlLfifFe15vjS
         kueMmtuIN4clBUDkg72AQTHy6ESan9auao6sYCccUJKHySuFWACWIUIXTbjGA84i9r6x
         795RQybmzA++PL0XOO/addrwQOEHKTM7Z3MCkgoO/plKSJ7R++k4LjocXRdpQ7yH9K6F
         8DwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUijUYxFDs4zAXolj6T1vSdrLrc2O85ra1XVwBm7jOCL6Hl0YCW6j9qps1tjW+5lf+Yyxc/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFMOlsxOVOTiuze+AATdSGg8M2j2Rd9lwV244pTMbR39ULQaG
	C3n9cHskP3iXcuINQE/MUKawoFDSuDDpTMkd2srli8p5THoFNh1bnWTKoswSpDBXdw==
X-Gm-Gg: ASbGncuH6JTup01eQaacGK7roUkDqCsOJoSHKDnTEmwI896E7MSvpV24X513o0GFzLv
	QuRj87gHhuj3i0hS7qMS4lgt8u1rROM9Lpf0shY3IDHg71VuHtNIlDGcSP0sDpLSWJJagpAcwqb
	jO35HNFIYJd2L/eDk/HCcD7Od6cqYCbYkRuOx3ZK3JrHRhWSbOytaI+vfQeMjrFak21ybVEiAkn
	BuAsKbkEJJ4V89Oa26+LWWg//keiujEGfsMUWNkq0Jtl03aN6w5IQY/Zl9PCtSB7fidktk8PqGx
	TJrm9F18JqDn9Ux9/8uqu4QHBGRGoGGqNXzK/KKK5woo0Kw0ezAFPmjBHoV5KWsSKBJ2B4diChb
	jcKKMXLedlUIZVorlZp9LE6l5DQKwefrRjnLMUSaw3YDpXLb+5qX4xmaaWLpGsXnUVUGO0JFYAL
	Cq5H2TxIulRQoS0jH9JxewjnelBh/licdzOHYUlARTlQ5V5MhvIIUtvDPH
X-Google-Smtp-Source: AGHT+IHPxqEW49Ey0+zH+V6NlQOHGZMBbZmRTn/CRr7R/OqlH3S491uTZTrMlBZvDnudHLtpe1IUUQ==
X-Received: by 2002:a05:6402:3582:b0:639:fd12:65a2 with SMTP id 4fb4d7f45d1cf-63ed84965d2mr2330090a12.15.1761641686193;
        Tue, 28 Oct 2025 01:54:46 -0700 (PDT)
Received: from google.com (96.211.141.34.bc.googleusercontent.com. [34.141.211.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef96105sm8342279a12.19.2025.10.28.01.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:54:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 08:54:41 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, jmorris@namei.org,
	serge@hallyn.com, casey@schaufler-ca.com, kpsingh@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	john.johansen@canonical.com, eparis@redhat.com,
	audit@vger.kernel.org
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
Message-ID: <aQCE0WwGlOADI5xT@google.com>
References: <20251025001022.1707437-1-song@kernel.org>
 <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
 <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>

On Mon, Oct 27, 2025 at 09:50:11PM -0400, Paul Moore wrote:
> On Mon, Oct 27, 2025 at 6:45 PM Song Liu <song@kernel.org> wrote:
> > On Mon, Oct 27, 2025 at 2:14 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Oct 24, 2025 at 8:10 PM Song Liu <song@kernel.org> wrote:
> > > >
> > > > lsm_prop_bpf is not used in any code. Remove it.
> > > >
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > > >
> > > > ---
> > > >
> > > > Or did I miss any user of it?
> > > > ---
> > > >  include/linux/lsm/bpf.h  | 16 ----------------
> > > >  include/linux/security.h |  2 --
> > > >  2 files changed, 18 deletions(-)
> > > >  delete mode 100644 include/linux/lsm/bpf.h
> > >
> > > You probably didn't miss any direct reference to lsm_prop_bpf, but the
> > > data type you really should look for when deciding on this is
> > > lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
> > > struct instead of secid tokens, and without a lsm_prop_bpf
> > > struct/field in the lsm_prop struct a BPF LSM will be limited compared
> > > to other LSMs.  Perhaps that limitation is okay, but it is something
> >
> > I think audit is the only user of lsm_prop (via audit_names and
> > audit_context). For BPF based LSM or audit, I don't think we need
> > specific lsm_prop. If anything is needed, we can implement it with
> > task local storage or inode local storage.
> >
> > CC audit@ and Eric Paris for more comments on audit side.
> 
> You might not want to wait on a comment from Eric :)
> 
> > > that should be discussed; I see you've added KP to the To/CC line, I
> > > would want to see an ACK from him before I merge anything removing
> > > lsm_prop_bpf.
> >
> > Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> > with his Reviewed-by?
> 
> Good to know, I wasn't aware that Matt was also listed as a maintainer
> for the BPF LSM.  In that case as long as there is an ACK, not just a
> reviewed tag, I think that should be sufficient.

ACK.

> > > I haven't checked to see if the LSM hooks associated with a lsm_prop
> > > struct are currently allowed for a BPF LSM, but I would expect a patch
> > > removing the lsm_prop_bpf struct/field to also disable those LSM hooks
> > > for BPF LSM use.
> >
> > I don't think we need to disable anything here. When lsm_prop was
> > first introduced in [1], nothing was added to handle BPF.
> 
> If the BPF LSM isn't going to maintain any state in the lsm_prop
> struct, I'd rather see the associated LSM interfaces disabled from
> being used in a BPF LSM just so we don't run into odd expectations in
> the future.  Maybe they are already disabled, I haven't checked.

Well, it doesn't ATM, but nothing goes to say that this will change in
the future. Until then though, I have no objections around removing
lsm_prop_bpf from lsm_prop as there's currently no infrastructure in
place allowing a BPF LSM to properly harness lsm_prop/lsm_prop_bpf. By
harness, I mean literaly using lsm_prop/lsm_prop_bpf as some form of
context storage mechanism.

As for the disablement of the associated interfaces, I don't feel like
this warranted at this point? Doing so might break some out-of-tree
BPF LSM implementations, specifically those that might be using these
associated LSM interfaces purely for instrumentation purposes at this
point?
